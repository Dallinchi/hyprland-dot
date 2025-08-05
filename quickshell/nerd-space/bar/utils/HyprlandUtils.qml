pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

import "root:/"

Singleton {
    id: hyprland

    property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values
    property list<HyprlandWorkspace> focusedmonitor_workspaces: filterWorkspacesByMonitor(Hyprland.focusedMonitor.id)
    property int maxWorkspace: findMaxId()
    
    function switchWorkspace(w: int): void {
        Hyprland.dispatch(`workspace ${w}`);
    }

    function findMaxId(): int {
        if (hyprland.workspaces.length === 0) {
            // console.log("No workspaces found, defaulting to 1");
            return 1; // Return 1 if no workspaces exist
        }
        let num = hyprland.workspaces.length;
        let maxId = hyprland.workspaces[num - 1]?.id || 1;
        // console.log("Current max workspace ID:", maxId);
        return maxId;
    }

    function filterWorkspacesByMonitor(monitorId: int) {
        let minId = (monitorId === 0) ? 0 : 8;
        let maxId = (monitorId === 0) ? 9 : 17;
        return Hyprland.workspaces.values.filter(ws => ws.id < maxId && ws.id > minId);
    }

    Process {
      id: procWorkspaceStatus
      command: ["sh", "-c", "~/.config/quickshell/nerd-space/scripts/workspace_state_scribe " + Hyprland.focusedWorkspace.id]
      running: false

      stdout: SplitParser {
          onRead: data => {
            switch (data) {
                case "default":
                {
                  Theme.get.background = Theme.get.backgroundDefault 
                  break
                }
                case "empty":
                {
                  // Theme.get.barBgColor = "#00000000"
                  Theme.get.background = Theme.get.backgroundEmpty 
                  break
                }
                case "solo":
                {
                  // Theme.get.barBgColor = "#70000000" 
                  Theme.get.background = Theme.get.backgroundActive 
                  break
                }
            }
          }
      }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            let eventName = event.name;
            procWorkspaceStatus.running = true

            for (let i=0;i < hyprland.focusedmonitor_workspaces.length;i++) {
              console.log(hyprland.focusedmonitor_workspaces[i].id)
              
              // let minId = (0 === 0) ? 1 : 9;
              // let maxId = (0 === 0) ? 9 : 17;
              // copiedWorkspaces = copiedWorkspaces.filter(ws => ws.id <= maxId && ws.id >= minId);
              //
              // for (let j=0;j<copiedWorkspaces.length; j++) {
              //   console.log("filtered: "+copiedWorkspaces[j].id)
              // }
    
            }
            switch (eventName) {
            case "createworkspacev2":
                {
                    // console.log("Workspace created, updating workspace list");
                    hyprland.workspaces = hyprland.sortWorkspaces(Hyprland.workspaces.values);
                    hyprland.maxWorkspace = findMaxId();
                }
            case "destroyworkspacev2":
                {
                    // console.log("Workspace destroyed, updating workspace list");
                    hyprland.workspaces = hyprland.sortWorkspaces(Hyprland.workspaces.values);
                    hyprland.maxWorkspace = findMaxId();
                }
            }
        }
    }
}

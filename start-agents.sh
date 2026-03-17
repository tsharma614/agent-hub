#!/bin/bash
# Agent Hub — tmux session launcher
# Usage: ./start-agents.sh

SESSION="hub"

# Kill existing session if running
tmux kill-session -t $SESSION 2>/dev/null

# Create session with hub window
tmux new-session -d -s $SESSION -n "hub" -c "$HOME/repos/agent-hub"

# Create a window for each project (no Claude running — just the shell, zero RAM)
tmux new-window -t $SESSION -n "pkmn" -c "$HOME/repos/pkmn-btl-sim"
tmux new-window -t $SESSION -n "godeal" -c "$HOME/repos/goDealApp"
tmux new-window -t $SESSION -n "absnot" -c "$HOME/repos/AbsolutelyNot"
tmux new-window -t $SESSION -n "trusha" -c "$HOME/repos/trusha-job-search"

# Go back to hub window
tmux select-window -t $SESSION:0

# Launch Claude in the hub window
tmux send-keys -t $SESSION:0 "claude" Enter

echo "Hub session started. Attach with: tmux attach -t $SESSION"
echo ""
echo "Windows:"
echo "  0: hub     (agent-hub — Claude running)"
echo "  1: pkmn    (pkmn-btl-sim)"
echo "  2: godeal  (goDealApp)"
echo "  3: absnot  (AbsolutelyNot)"
echo "  4: trusha  (trusha-job-search)"
echo ""
echo "Switch windows: Ctrl+B then 0-4"
echo "Launch Claude in a project: switch to its window, type 'claude'"

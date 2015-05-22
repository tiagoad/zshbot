#!/usr/bin/env zsh

# > VERSION
# < VERSION zshbot v?.?.?
function ircCtcpVersion {
	sendCtcpReponse "$nick" "VERSION zshbot v$VERSION"
}
addIrcHook CTCP_VERSION ircCtcpVersion

# > PING 1432301094 27740
# < PONG 1432301094 27740
function ircCtcpPing {
	sendCtcpReponse "$nick" "PING $@[2,-1]"
}
addIrcHook CTCP_PING ircCtcpPing

# > TIME
# < Fri May 22 14:37:21 WEST 2015
function ircCtcpTime {
	sendCtcpReponse "$nick" "TIME :$(date)"
}
addIrcHook CTCP_TIME ircCtcpTime
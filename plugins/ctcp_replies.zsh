#!/usr/bin/env zsh

# > VERSION
# < VERSION zshbot v?.?.?
function zshbot.ctcp_replies.version {
	zshbot.util.sendCtcpReponse "$nick" "VERSION zshbot v$VERSION"
}
zshbot.hooks.registerHook CTCP_VERSION zshbot.ctcp_replies.version

# > PING 1432301094 27740
# < PONG 1432301094 27740
function zshbot.ctcp_replies.ping {
	zshbot.util.sendCtcpReponse "$nick" "PING $@[2,-1]"
}
zshbot.hooks.registerHook CTCP_PING zshbot.ctcp_replies.ping

# > TIME
# < Fri May 22 14:37:21 WEST 2015
function zshbot.ctcp_replies.time {
	zshbot.util.sendCtcpReponse "$nick" "TIME :$(date)"
}
zshbot.hooks.registerHook CTCP_TIME zshbot.ctcp_replies.time
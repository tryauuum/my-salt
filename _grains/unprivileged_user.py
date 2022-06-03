import pwd
import logging
UID = 1000 # usually the uid of the first non-privileged user on ubuntu

log = logging.getLogger(__name__)

def function():
    grains = {}
    try:
        grains['unprivileged_user'] = pwd.getpwuid(UID).pw_name
    except KeyError:
        grains['unprivileged_user'] = None
    log.trace(f'custom grain {grains}')
    return grains

*** Settings ***
Documentation    Keywords for working with the MicroShift host
Library          SSHLibrary


*** Keywords ***
Login MicroShift Host
    [Documentation]  Login to the MicroShift host via ssh and leave the connection open
    ...
    ...  This keyword is meant to be used at the suite level. This ensures
    ...  most tests already have an open connection. Any tests that will take
    ...  action that disrupt that connection are responsible for restoring it.

    Log  Host: ${USHIFT_HOST}
    SSHLibrary.Open Connection    ${USHIFT_HOST}
    # If there is an ssh key set in the global configuration, use that to
    # login to the host. Otherwise assume that the ssh agent is running
    # and configured properly.
    IF  '${SSH_PRIV_KEY}'
        SSHLibrary.Login With Public Key    ${USHIFT_USER}    ${SSH_PRIV_KEY}
    ELSE
        SSHLibrary.Login    ${USHIFT_USER}  allow_agent=True
    END

Logout MicroShift Host
    [Documentation]  Close the open ssh connection to the MicroShift host
    SSHLibrary.Close Connection

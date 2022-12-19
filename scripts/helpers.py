# third party packages imports
from brownie import network, accounts, config

def get_account():
    if network.show_active() != "development":
        
        # getting my goerli account
        return accounts.add(config['wallets']['goerli'])
    else:
        return accounts[0]


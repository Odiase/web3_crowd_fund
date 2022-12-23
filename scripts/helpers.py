# third party packages imports
from brownie import network, accounts, config, CrowdFundFactory

def get_account():
    '''Gets a ethereum account based on the network'''
    if network.show_active() != "development":
        
        # getting my goerli account
        return accounts.add(config['wallets'][network.show_active()])
    else:
        return accounts[0]


def get_factory_contract():
    '''return the latest deployed CrowdFundFactory contract'''
    
    return CrowdFundFactory[-1]

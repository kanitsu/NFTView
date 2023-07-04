# NFTView

## How to use
Open terminal at root folder and run 

`pod install`

Then, open the workspace (`NFTView.xcworkspace`) file with xCode, build and run.

The first page shows current wallet address, balance in ETH and list of NFTs.

Clicking any name or thumbnail of the NFT will open detail page.

NFT detail page shows its collection name, image, name description and permalink button. Tapping permalink button will open the NFT page on OpenSea via browser.


## Note
The App doesn't use API key for Opensea. If the NFT list is empty,  please verify if the quota is still available.

Erroneous image including because of null URL, will be replaced with an image of red triangle with white exclamation mark (error-icon image in Assets.xcassets)

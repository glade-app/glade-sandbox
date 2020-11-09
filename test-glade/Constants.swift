struct Constants {
    static let clientID = "cb83fc0fc34a405a918e3ffda44dd2f1"
    static let redirectURI = URL(string: "test-glade-login://callback")!
    static let sessionKey = "spotifySessionKey"
    static let tokenSwapURL = URL(string: "https://test-glade-token-swap.herokuapp.com/api/token")
    static let tokenRefreshURL = URL(string: "https://test-glade-token-swap.herokuapp.com/api/refresh_token")
}

public struct Flashcard  {
    public let text: String
    public let answer: String!

    
    
    
    
    
    
    
    
    public init(text: String, answer: String?) {
        self.text = text
        self.answer = answer!
    }
}

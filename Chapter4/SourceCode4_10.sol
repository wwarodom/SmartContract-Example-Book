    string [] text;
    constructor() {
        // Must initial value, unless hello cannot point to text variable
        text.push("hello");  
    }
    
    function useMemory() public {
        string memory str1;
        str1 =  text[0];       // Copy “hello” value
        // Modify memory variable
        str1 = "hello";
    }
    
    function useStorage() public {
        string storage str2;   // Point to “hello” value referenced by text
        str2 = text[0];
        // Modify text (state variable)
        text[0] = "hello";     
    }

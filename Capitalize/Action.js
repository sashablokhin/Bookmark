//
//  Action.js
//  Capitalize
//
//  Created by Alexander Blokhin on 08.03.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

var Action = function() {};

Action.prototype = {
    
run: function(arguments) {
    
    arguments.completionFunction({"content": document.body.innerHTML});
},
    
finalize: function(arguments) {
    document.body.innerHTML = arguments["content"];
}
    
};

var ExtensionPreprocessingJS = new Action

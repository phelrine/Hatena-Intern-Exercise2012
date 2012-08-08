var Template = function(input) {
    this.template = input.source;
};

Template.prototype = {
    render: function(variables) {
        for (var k in variables) {
            s = variables[k];
	        s = s.replace(/&/g,'&amp;');
	        s = s.replace(/>/g,'&gt;');
	        s = s.replace(/</g,'&lt;');
            s = s.replace(/"/g,'&quot;');
            variables[k] = s;
        }

        var html = this.template.replace(/{%\s*(\w+)\s*%}/g, function(){
            return variables[RegExp.$1];
        });

        return html;
    }
};

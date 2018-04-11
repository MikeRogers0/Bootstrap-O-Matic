// https://codepad.co/snippet/zRykJud8
String.prototype.capitalize = function() {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

String.prototype.titleize = function() {
  var string_array = this.split(' ');
  string_array = string_array.map(function(str) {
    return str.capitalize(); 
  });

  return string_array.join(' ');
}

String.prototype.parameterize = function() {
  return this.toLowerCase().replace(' ', '-');
}

String.prototype.replaceVariables = function(variableMap) {
  var string = this;
  Object.keys(variableMap).forEach(function(item, index){
    string = string.replace(RegExp(item, "g"), variableMap[item]);
  });
  return string;
}

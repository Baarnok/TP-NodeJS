module.exports = {
	save: function (name, callback) {
		// Code ...
		var user = {
			id: "2222",
			name: name
		}
		callback(name);
	},
	get: function (id, callback) {
		// Get a user
		var user = {
			name: "francois",
			id: id
		}
		callback(id);
	}
}

/**
 * Copyright (c) 2011 Bruno Jouhier <bruno.jouhier@sage.com>
 * MIT License
 */
(function(exports) {
	exports.future = function(fn, args, i) {
		var err, result, done, q = [], self = this;
		args = Array.prototype.slice.call(args);
		args[i] = function(e, r) {
			err = e, result = Array.prototype.slice.call(arguments, 1), done = true;
			q && q.forEach(function(f) {
				f.apply(self, [err].concat(result));
			});
			q = null;
		};
		fn.apply(this, args);
		return function F(cb) {
			if (!cb) return F;
			if (done) cb.apply(self, [err].concat(result));
			else q.push(cb);
		}
	}
})(typeof exports !== 'undefined' ? exports : (Streamline.future = Streamline.future || {}));


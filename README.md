# Histogram utility
Common Lisp histogram utility. Nothing advanced.
The system and package are named `histogram`.

## Functions

### Instantiation
`(make-hist bounds nbins &key data)`

Create an instance of `hist`.
* `bounds`: List with the min/max bounds for the histogram.
  `(min-bound max-bound)`
* `nbins`: Number of bins in the histogram.
* `data`: A data vector can be provided optionally. It is added
          to the histogram during the instantiation.

The bins are of equal size and spread uniformly between the
min and max bounds.

### Adding data
`(add hist data)`

Add data to the histogram. `data` is a vector of values.
This method can be called at any point during the life
of the `hist` instance.

### Reading histogram properties

`(counts hist)`

Read the vector of counts inside the bins.

`(center-of-bins hist)`

Read the vector of values corresponding to the center of each bin.

`(oob-counts hist)`

Read the list `(counts-below counts-above)` that counts the
number of occurences that fell below or above the histogram
bounds.

`(total-counts hist)`

Read the total number of occurences that were fed to the histogram.
This includes the values that are out-of-bounds.

`(bounds hist)`

Read the histogram bounds. Same as input argument.

`(min-bound hist)`

Read the min bound of the histogram.

`(max-bound hist)`

Read the max bound of the histogram.

`(nbins hist)`

Read the number of bins in the histogram. Same as input argument.

`(bin-size hist)`

Read the computed size of an individual bin.

## Example


## Dependencies
* `histogram`: None.
* `histogram/test`:
  * [rove](https://github.com/fukamachi/rove)

## Tests
Run tests with:

```common-lisp
(asdf:test-system "histogram")
```

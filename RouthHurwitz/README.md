# Routh Hurwitz Stability Criterion
[Concept](https://www.sciencedirect.com/topics/engineering/routh-hurwitz-criterion)

![image](https://user-images.githubusercontent.com/88243850/156844727-fd4149df-f02d-4790-9223-279d7cd54811.png)

Evaluate and count sign changes to determine stability.

## Two Cases

### Zero In first Column
![image](https://user-images.githubusercontent.com/88243850/156845057-fc7af45b-5ca0-45e3-a4b8-e74ec5466550.png)
1. Replace zero with an epsilon.
2. Compute table like normal.
3. Take a limit of the table as e -> 0 from the left or the right.
4. Count up the sign changes.

### Row of Zeros
![image](https://user-images.githubusercontent.com/88243850/156845496-393d97d1-9ee1-40f7-88a2-94fa08000869.png)
1. Look at the line above the row of zeros and create an auxilary polynomial.

![image](https://user-images.githubusercontent.com/88243850/156845623-e5dfb4bf-d035-44dc-96d9-b8f93b8a33c9.png)

2. Take the derivative of this polynomial,

![image](https://user-images.githubusercontent.com/88243850/156845844-d1ecdd0f-59f9-4857-a272-d8c3627101ed.png)

3.  Replace the row of zeros with the coefficients of the derivative.

![image](https://user-images.githubusercontent.com/88243850/156845958-1be8bea6-7a37-4414-8b38-e7177d87bc59.png)

4. Count up the sign changes to determine stability.

[Site for Pictures used](https://www.circuitbread.com/tutorials/routh-hurwitz-criterion-part-2-3-3)

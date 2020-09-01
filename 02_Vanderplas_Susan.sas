/* SAS file for homework 2 */

/* ---------------------------------------------------------------------------*/
/* Fizzbuzz                                                                   */
/* ---------------------------------------------------------------------------*/

PROC IML;

/* FizzBuzz code goes here */
z = '';
DO i = 1 to 30;
  a = '';
  IF MOD(i, 5)=0 THEN DO;
    a = cats(a,"Fizz");
    END;
  if MOD(i,3)=0 THEN DO;
    a = cats(a,"Buzz");
    END;
  IF a = '' THEN DO;
    a = cats(a, i);
    END;
  z = catx(' ', z, a);
END;

PRINT z;

QUIT;


/* ---------------------------------------------------------------------------*/
/* Linear Regression                                                          */
/* ---------------------------------------------------------------------------*/

PROC IMPORT datafile = "amazon_books.csv" out=books
  DBMS = csv /* comma delimited file */
  REPLACE;
  GETNAMES = YES;

PROC REG data=books;
    MODEL Amazon_Price = List_Price Hardcover NumPages;
RUN;

PROC IML;
USE books;
   read all var _NUM_ INTO X1[colname=varname]; /* Read numeric vars */
CLOSE books;

Y = X1[,1]; /* Y pulled out */
X1[,1] = 1; /* Intercept column */
varname[1] = "Intercept";
varname_t = varname`; /* Make them a column vector to match the fitted coefs */
/* PRINT Y X1 varname_t;*/ /* Just checking */

res = inv(X1`*X1) * X1`*Y;
PRINT varname_t res; /* Print coefs with labels */
QUIT;

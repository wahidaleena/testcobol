       working-storage section.
             exec sql begin declare section end-exec
           * Examples of host variables declared in a
           * DECLARE section
             01 filler.
                 03 cust-no pic 9(4) packed-decimal.
                 03 cust pic X(20).
             exec sql end declare section end-exec
           * Example of host variable not declared in a
           * DECLARE section
             01 house-no pic 9(4) comp.
             exec sql include sqlca end-exec

            procedure  division.
                 exec sql declare cust cursor for
                     select custno, custname, hseno
                     from region where postdept = 'rg1'
                 end-exec
                 exec sql open cust end-exec

                 perform until sqlcode not = 0
                     exec sql
                         fetch cust into :cust-no, :cust, :house-no
                     end-exec

                     display "customer-no: " cust-no
                             "  customer-name: " cust
                             "  house-no: " house-no
                 end-perform

                 exec sql close cust end-exec

                 stop run.

/;
DROP procedure IF EXISTS plus1inout
/;
CREATE procedure plus1inout (IN arg int, OUT res int)  
BEGIN ATOMIC  
	set res = arg + 1; 
END
/;
DROP procedure IF EXISTS plus1inout2
/;
CREATE procedure plus1inout2 (IN arg int, OUT res int, OUT res2 int)
BEGIN ATOMIC
	set res = arg + 1;
	set res2 = arg + 2;
END
/;
DROP procedure IF EXISTS procedure_in1_out1
/;
DROP procedure IF EXISTS procedure_in1_out0
/;
DROP procedure IF EXISTS procedure_in0_out1
/;
DROP procedure IF EXISTS procedure_in1_out0_return_rs_no_update
/;
DROP procedure IF EXISTS procedure_in1_out0_return_rs_with_update
/;
DROP procedure IF EXISTS procedure_in1_out0_no_return_with_update
/;

DROP table dummy if exists
/;
create table dummy (id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, name VARCHAR(32))
/;
insert into public.dummy(name) values ('A')
/; 
insert into public.dummy(name) values ('B')
/; 
insert into public.dummy(name) values ('C')
/;

/;
CREATE procedure procedure_in1_out1 (IN arg int, OUT res int)
BEGIN ATOMIC 
set res = arg + 1; 
END
/;

CREATE procedure procedure_in1_out0 (IN arg int)
BEGIN ATOMIC
DECLARE res int;
set res = arg + 1; 
END
/;

CREATE procedure procedure_in0_out1 (OUT res int)
BEGIN ATOMIC
set res = 42;
END
/;

CREATE procedure procedure_in1_out0_return_rs_no_update (IN arg varchar(32))
READS SQL DATA DYNAMIC RESULT SETS 1
BEGIN ATOMIC
DECLARE result CURSOR WITH RETURN FOR SELECT * FROM public.dummy FOR READ ONLY;
open result;
END
/;

CREATE procedure procedure_in1_out0_return_rs_with_update (IN arg varchar(32))
MODIFIES SQL DATA DYNAMIC RESULT SETS 1
BEGIN ATOMIC
DECLARE result CURSOR WITH RETURN FOR SELECT * FROM public.dummy FOR READ ONLY;
update public.dummy set name = name;
OPEN result;
END
/;

CREATE procedure procedure_in1_out0_no_return_with_update (IN arg varchar(32))
MODIFIES SQL DATA
BEGIN ATOMIC
update public.dummy set name = name;
END
/;

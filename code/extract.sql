copy (select diag_code, diag_desc, count(*) as n
	from admission_diagnosis ad JOIN diagnosis_desc dd USING (diag_code )
	where ad.position=1
	GROUP BY 1,2 
	order by count(*) desc
	limit 100) to '/tmp/top_10_diag.csv' with csv header; 

create table temp.top100_pd as (select diag_code, diag_desc, count(*) as n
from admission_diagnosis ad JOIN diagnosis_desc dd USING (diag_code )
where ad.position=1
GROUP BY 1,2 
order by count(*) desc
limit 100) ; 

alter table temp.top100_pd add primary key( diag_code );

select sum(n) from temp.top100_pd;

select  accommodation_type, pin, diag_code, LOS, seperation_mode
from admission a JOIN admission_diagnosis ad ON (admission_id)
JOIN temp.top100_pd 

where position=1


copy (
	
	select diag_code, diag_desc, count(*) as n
	from admission_diagnosis ad JOIN diagnosis_desc dd USING (diag_code )
	where ad.position=1
	GROUP BY 1,2 
	order by count(*) desc
	limit 100) to '/tmp/top_10_diag.csv' with csv header


-- extract data from admission_table

select admission_id as patient_id, sep_mode_desc, sex_desc, adm_type_desc, los
d1.diagnosis_code as diag_code_1,
d2.diagnosis_code as diag_code_2,
d3.diagnosis_code as diag_code_3,
p1.procedure_code as proc_code_1,
p2.procedure_code as proc_code_2,
p3.procedure_code as proc_code_3
from admission a 
JOIN sex USING (sex_id)
JOIN separation_mode USING (separation_mode_id)
JOIN admission_type USING (adm_type_desc)
LEFT JOIN admission_diagnosis d1 USING (admission_id)
LEFT JOIN admission_diagnosis d2 USING (admission_id)
LEFT JOIN admission_diagnosis d3 USING (admission_id)
LEFT JOIN admission_procedure p1 USING (admission_id)
LEFT JOIN admission_procedure p2 USING (admission_id)
LEFT JOIN admission_procedure p3 USING (admission_id)
WHERE 
d1.position=1 AND
d2.position=2 AND
d3.position=3 AND
p1.position=1 AND
p2.position=2 AND
p3.position=3 
limit 10;


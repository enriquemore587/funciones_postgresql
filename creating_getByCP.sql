/*SELECT colonia FROM cw.colony where cp = '55100';

SELECT id_estado FROM cw.colony where cp = '55100';

SELECT id_mnpio FROM cw.colony where cp = '55100';



SELECT descripcion FROM cw.states WHERE id 
	in(
		SELECT id_estado FROM cw.colony where cp = '55100'
	);

SELECT * FROM cw.municipalities WHERE id_states
	in(
		SELECT id_estado FROM cw.colony where cp = '55100'
	);


SELECT 

c.colonia, 

st.descripcion as estado, st.id:: INTEGER as id_estado

,mu.descripcion as municipio 

FROM cw.colony as c

INNER JOIN cw.states as st ON st.id = c.id_estado

INNER JOIN cw.municipalities as mu ON mu.id_states = st.id

where cp = '55100';

*/
select cw.getCatsByCP('55100');


create or replace view dbp_msi_view_log.mv_ewm_exception_kategorie_zu_prompt_2
as
----2021-03-18 | nwag2310 | AP0080760 | initial
select
ewm_exc_kategorie_id,
ewm_exception_id
from dbp_view.v_l_ewm_exception_2
WHERE LEFT(lagernummer_id ,1) in ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(lagernummer_id))=4
group by ewm_exc_kategorie_id, ewm_exception_id;
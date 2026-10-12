CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_BESCHAFFUNGSLOGISTIK_REFERENZNUMMER_2(
	BELOS_VORGANG_ID,
	MANDANT_ID,
	BELOS_VORGANGART_ID,
	REFERENZNUMMER_ID,
	BELOS_LIEFERSCHEIN_ID
	
) AS
--2022-05-24,AP0112140, SPEC0155506, initial, dknop
--2022-11-23, AP0112140, SPEC0155506, adding listagg for referenznummer_id and belos_lieferschein_id - duplicated rows, dknop
SELECT
belos_vorgang_id,
mandant_id,
belos_vorgangart_id,
LISTAGG (DISTINCT referenznummer_id, ';'),-- WITHIN GROUP (ORDER BY  mandant_id, belos_vorgang_id),
LISTAGG (DISTINCT belos_lieferschein_id, ';')-- WITHIN GROUP (ORDER BY  mandant_id, belos_vorgang_id)
--gp_id
FROM (
SELECT 
b_vor.belos_vorgang_id,
b_vor.mandant_id,
b_vor.belos_vorgangart_id,
--LISTAGG(a.best_beleg_id, ',') WITHIN GROUP(ORDER BY a.mandant_id , a.transportation_unit_id)
TRY_CAST(b_vor.belos_bestell_beleg_id_extern AS DECIMAL(18,0)) AS referenznummer_id,
b_vor.belos_lieferschein_id AS belos_lieferschein_id,
bb.gp_id

FROM dbp_view.v_belos_vorgang_2 b_vor

LEFT JOIN dbp_view.v_besch_best_2 bb
ON TRY_CAST(b_vor.belos_bestell_beleg_id_extern AS DECIMAL(18,0)) =bb.best_beleg_id
AND b_vor.mandant_id=bb.mandant_id
               
WHERE b_vor.belos_vorgangart_id='K-NA' 

UNION

SELECT
b_vor.belos_vorgang_id,
b_vor.mandant_id,
b_vor.belos_vorgangart_id,
bbb_vor.best_beleg_id AS referenznummer_id,
COALESCE(bes_b.ext_beleg_id,'-1') AS belos_lieferschein_id,
bb.gp_id

FROM dbp_view.v_belos_vorgang_2 b_vor

LEFT JOIN dbp_view.v_besch_best_belos_vorgang_zu_2 bbb_vor
ON b_vor.belos_vorgang_id=bbb_vor.belos_vorgang_id
AND b_vor.mandant_id=bbb_vor.mandant_id

LEFT JOIN dbp_view.v_besch_bestaetigung_2 bes_b
ON bbb_vor.best_beleg_id =bes_b.best_beleg_id
AND bbb_vor.mandant_id=bes_b.mandant_id

LEFT JOIN dbp_view.v_besch_best_2 bb
ON bbb_vor.best_beleg_id =bb.best_beleg_id
AND bbb_vor.mandant_id=bb.mandant_id

WHERE b_vor.belos_vorgangart_id<>'K-NA')

--where belos_vorgang_id=16666490

GROUP BY
belos_vorgang_id,
mandant_id,
belos_vorgangart_id
--gp_id

;
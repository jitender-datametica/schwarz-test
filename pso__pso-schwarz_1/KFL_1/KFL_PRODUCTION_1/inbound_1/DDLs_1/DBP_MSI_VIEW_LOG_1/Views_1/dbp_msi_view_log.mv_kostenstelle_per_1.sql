CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_KOSTENSTELLE_PER_1(
	MANDANT_ID,
	KOSTENSTELLE_ID,
	KOSTENSTELLE_BEZ,
	DAT
) AS
--2023-06-29, AP0145540,SPEC0182434, dknop, initial 
SELECT
 mandant_id
,kostenstelle_id
,kostenstelle_bez
,dat
FROM dbp_view.v_kostenstelle_per_1
JOIN dbp_view.v_tag_1
ON dat BETWEEN dat_von AND dat_bis

UNION

SELECT
 mandant_id
,'0'
,'manuell erfasst'
,dat

FROM dbp_view.v_tag_1
JOIN dbp_view.v_mandant_1

WHERE akt_kj>=-2

UNION 

SELECT
 h_tag.mandant_id
,h_tag.kostenstelle_id
,k_p.kostenstelle_bez
,h_tag.dat
FROM dbp_view.v_hydra_taetigkeit_tag_1 h_tag
LEFT JOIN dbp_view.v_kostenstelle_per_1 k_p
ON dat BETWEEN dat_von AND dat_bis
AND h_tag.mandant_id=k_p.mandant_id
AND h_tag.kostenstelle_id=k_p.kostenstelle_id
WHERE k_p.kostenstelle_bez IS NULL
AND h_tag.kostenstelle_id <>''
;
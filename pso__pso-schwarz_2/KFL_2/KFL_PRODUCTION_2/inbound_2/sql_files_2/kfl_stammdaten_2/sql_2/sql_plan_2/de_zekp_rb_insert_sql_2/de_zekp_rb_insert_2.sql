DELETE FROM dbp_data.art_gp_wup_zu_per_2
WHERE mandant_id = 1
;

INSERT INTO dbp_data.art_gp_wup_zu_per_2
SELECT *
FROM dbp_etl.zekp_original
WHERE mandant_id = 1
;

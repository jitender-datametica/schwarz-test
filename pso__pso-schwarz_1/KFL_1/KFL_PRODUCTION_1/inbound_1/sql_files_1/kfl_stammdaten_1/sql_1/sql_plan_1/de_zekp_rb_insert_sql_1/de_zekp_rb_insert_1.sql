DELETE FROM dbp_data.art_gp_wup_zu_per_1
WHERE mandant_id = 1
;

INSERT INTO dbp_data.art_gp_wup_zu_per_1
SELECT *
FROM dbp_etl.zekp_original
WHERE mandant_id = 1
;

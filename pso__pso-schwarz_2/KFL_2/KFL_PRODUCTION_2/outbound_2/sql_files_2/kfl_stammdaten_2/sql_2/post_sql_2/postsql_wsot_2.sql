UPDATE dbp_data.baustein_per_2 SET
    baustein_bez = b.vtext
FROM dbp_etl.wsot_2 AS b
WHERE baustein_per.mandant_id = 1 AND baustein_per.baustein_id = b.skopf;

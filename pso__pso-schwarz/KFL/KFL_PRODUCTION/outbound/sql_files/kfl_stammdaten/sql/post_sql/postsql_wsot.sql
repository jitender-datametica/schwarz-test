UPDATE dbp_data.baustein_per SET
    baustein_bez = b.vtext
FROM dbp_etl.wsot AS b
WHERE baustein_per.mandant_id = 1 AND baustein_per.baustein_id = b.skopf;

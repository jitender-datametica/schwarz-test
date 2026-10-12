--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_data.art_nielsen_fakten_kjmo_2 SET
    umsatz_brutto_af = x1.umsatz_brutto_af_,
    umsatz_brutto_sa = x1.umsatz_brutto_sa_,
    menge_af = x1.menge_af_,
    menge_sa = x1.menge_sa_ FROM (
    SELECT
        mandant_id AS mandant_id_,
        kjmo AS kjmo_,
        nielsen_market_id AS nielsen_market_id_,
        art_nielsen_id AS art_nielsen_id_,
        wrg_id AS wrg_id_,
        SUM(umsatz_brutto_af) AS umsatz_brutto_af_,
        SUM(umsatz_brutto_sa) AS umsatz_brutto_sa_,
        SUM(menge_af) AS menge_af_,
        SUM(menge_sa) AS menge_sa_
    FROM ${TEMP_TABLE}
    GROUP BY
        mandant_id_,
        kjmo_,
        nielsen_market_id_,
        art_nielsen_id_,
        wrg_id_
) AS x1
WHERE
    art_nielsen_fakten_kjmo.mandant_id = x1.mandant_id_ AND art_nielsen_fakten_kjmo.kjmo = x1.kjmo_ AND
    art_nielsen_fakten_kjmo.nielsen_market_id = x1.nielsen_market_id_ AND art_nielsen_fakten_kjmo.art_nielsen_id = x1.art_nielsen_id_;

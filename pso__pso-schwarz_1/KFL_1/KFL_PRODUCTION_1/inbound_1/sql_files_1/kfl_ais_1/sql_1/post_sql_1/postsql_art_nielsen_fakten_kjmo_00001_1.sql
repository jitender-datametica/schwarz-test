--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_DATA.art_nielsen_fakten_kjmo_1
SET    umsatz_brutto_af  = umsatz_brutto_af_
     , umsatz_brutto_sa  = umsatz_brutto_sa_
     , menge_af          = menge_af_
     , menge_sa          = menge_sa_

FROM 
(SELECT
  mandant_id            mandant_id_
, kjmo                  kjmo_
, nielsen_market_id     nielsen_market_id_
, art_nielsen_id        art_nielsen_id_
, wrg_id                wrg_id_
, sum(umsatz_brutto_af) umsatz_brutto_af_
, sum(umsatz_brutto_sa) umsatz_brutto_sa_
, sum(menge_af)         menge_af_
, sum(menge_sa)         menge_sa_
FROM ${TEMP_TABLE}
GROUP BY 1,2,3,4,5) x1

WHERE  mandant_id        = mandant_id_       AND
       kjmo              = kjmo_             AND
       nielsen_market_id = nielsen_market_id_ AND
       art_nielsen_id    = art_nielsen_id_;


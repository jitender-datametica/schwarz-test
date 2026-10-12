CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_lil_liam_dm_chart15_2 (liam_clnt_cat_id, currency_iso_cd, liam_prnt_cat_id,
client_id, per_id, clnt_rtl_id, clnt_rtl_lvl, liamvaluelidlcattototalshare, liamvaluepotlidlcattototalshar, valuelidl,
valuepotentiallidl, valuepotentialexploitationlidl, valuepotentialexploitation, vpegappp, avplidlsharebar,
addedvaluepotentiallidl, liamvaluelidltfmcg, maxrawbuyer, maxrawbuyerlidl, prot_fg) AS SELECT liam_clnt_cat_id,
 currency_iso_cd,
 liam_parnt_clnt_cat_id AS liam_prnt_cat_id,
 client_id,
 per_id,
 rtl_id AS clnt_rtl_id,
 rtl_tp_id AS clnt_rtl_lvl,
 liamvaluelidlcattototalshare,
 liamvaluepotlidlcattototalshar,
 REPLACE(CAST(valuelidl AS STRING FORMAT '999,999,999,999,999,999,999,999'), ',', '.') AS valuelidl,
 REPLACE(CAST(valuepotentiallidl AS STRING FORMAT '999,999,999,999,999,999,999,999'), ',', '.') AS valuepotentiallidl,
 REPLACE(CAST(valuepotentialexploitationlidl AS STRING FORMAT '999,999,999,999,999,999,999,999.9'), ',', '.') AS
 valuepotentialexploitationlidl,
 REPLACE(CAST(valuepotentialexploitation AS STRING FORMAT '999,999,999,999,999,999,999,999.9'), ',', '.') AS
 valuepotentialexploitation,
 REPLACE(CAST(vpegappp AS STRING FORMAT '999,999,999,999,999,999,999,999'), ',', '.') AS vpegappp,
 avplidlsharebar,
 REPLACE(CAST(addedvaluepotentiallidl AS STRING FORMAT '999,999,999,999,999,999,999,999.9'), ',', '.') AS
 addedvaluepotentiallidl,
 liamvaluelidltfmcg,
 maxrawbuyer,
 maxrawbuyerlidl,
 1 AS prot_fg
FROM ldl_p_lew_core_ac.v_wawi_lil_liam_dm_chart15_2;
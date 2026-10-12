/* #DescStart#
#$Revision: 7561 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_lil_liam_dm_chart15_1 (client_id, liam_parnt_clnt_cat_id, liam_clnt_cat_id
, per_id, rtl_id, rtl_tp_id, currency_iso_cd, liamvaluelidlcattototalshare, liamvaluepotlidlcattototalshar, valuelidl,
valuepotentiallidl, valuepotentialexploitationlidl, valuepotentialexploitation, vpegappp, avplidlsharebar,
addedvaluepotentiallidl, liamvaluelidltfmcg, maxrawbuyer, maxrawbuyerlidl) AS SELECT client_id,
 liam_parnt_clnt_cat_id,
 liam_clnt_cat_id,
 per_id,
 rtl_id,
 rtl_tp_id,
 currency_iso_cd,
 liamvaluelidlcattototalshare,
 liamvaluepotlidlcattototalshar,
 valuelidl,
 valuepotentiallidl,
 valuepotentialexploitationlidl,
 valuepotentialexploitation,
 vpegappp,
 avplidlsharebar,
 addedvaluepotentiallidl,
 liamvaluelidltfmcg,
 maxrawbuyer,
 maxrawbuyerlidl
FROM ldl_p_lew_core.t_wawi_lil_liam_dm_chart15_1;
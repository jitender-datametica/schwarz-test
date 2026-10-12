CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MK_ZEROVERKAUF as
   SELECT
   t01.wup_id, t01.nb_id, t01.mandant_id, t01.art_id, t01.dat, t01.zeitfenster_id, t01.aktion_fg, t01.art_fehlgrund_id, t01.menge_lgbest, t01.datzeit_letzter_abverkauf, t01.art_fehlgrund_text, t01.dat_erfasst, t01.melde_fg
   /*  Falls Abbildung als Fakt nicht funktioniert:
   ,CASE WHEN t01.zeitfenster_id = 1
   THEN CASE WHEN t01.dat_erfasst IS NULL THEN 0 ELSE 1 END
   ELSE NULL
   END status_zf1
   ,CASE WHEN t01.zeitfenster_id = 2
   THEN CASE WHEN t01.dat_erfasst IS NULL THEN 0 ELSE 1 END
   ELSE NULL
   END status_zf2
   ,CASE WHEN t01.zeitfenster_id = 2
   THEN CASE WHEN t01.dat_erfasst IS NULL THEN 0 ELSE 1 END
   ELSE NULL
   END status_zf3
   ,CASE WHEN t01.zeitfenster_id = 1
   THEN t01.melde_fg
   ELSE NULL
   END melde_fg_zf1
   ,CASE WHEN t01.zeitfenster_id = 2
   THEN t01.melde_fg
   ELSE NULL
   END melde_fg_zf2
   ,CASE WHEN t01.zeitfenster_id = 3
   THEN t01.melde_fg
   ELSE NULL
   END melde_fg_zf3
   ,CASE WHEN t01.zeitfenster_id = 1
   THEN t01.menge_lgbest
   ELSE NULL
   END menge_lgbest_zf1
   ,CASE WHEN t01.zeitfenster_id = 2
   THEN t01.menge_lgbest
   ELSE NULL
   END menge_lgbest_zf2
   ,CASE WHEN t01.zeitfenster_id = 3
   THEN t01.menge_lgbest
   ELSE NULL
   END menge_lgbest_zf3
   ,CASE WHEN t01.zeitfenster_id = 1
   THEN t01.art_fehlgrund_text
   ELSE NULL
   END art_fehlgrund_text_zf1
   ,CASE WHEN t01.zeitfenster_id = 2
   THEN t01.art_fehlgrund_text
   ELSE NULL
   END art_fehlgrund_text_zf2
   ,CASE WHEN t01.zeitfenster_id = 3
   THEN t01.art_fehlgrund_text
   ELSE NULL
   END art_fehlgrund_text_zf3
   ,CASE WHEN t01.zeitfenster_id = 1
   THEN t01.datzeit_letzter_abverkauf
   ELSE NULL
   END datzeit_letzter_abverkauf_zf1
   ,CASE WHEN t01.zeitfenster_id = 2
   THEN t01.datzeit_letzter_abverkauf
   ELSE NULL
   END datzeit_letzter_abverkauf_zf2
   ,CASE WHEN t01.zeitfenster_id = 3
   THEN t01.datzeit_letzter_abverkauf
   ELSE NULL
   END datzeit_letzter_abverkauf_zf3
   ,CASE WHEN t01.zeitfenster_id = 1
   THEN t01.dat_erfasst
   ELSE NULL
   END dat_erfasst_zf1
   ,CASE WHEN t01.zeitfenster_id = 2
   THEN t01.dat_erfasst
   ELSE NULL
   END dat_erfasst_zf2
   ,CASE WHEN t01.zeitfenster_id = 3
   THEN t01.dat_erfasst
   ELSE NULL
   END dat_erfasst_zf3
   */
   FROM
   dbp_view.v_mk_zeroverkauf t01
   ;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_user_vt_wup_zu_1 AS WITH WUP_BASIS AS (SELECT WD.mandant_id,
   WD.wup_id,
   WP.land_id,
   WP.wup_standort,
   WP.dat_von,
   WP.dat_eroeffnung,
   WP.dat_bis,
   WD.vkl_id,
   WD.gf_gbl_vertrieb_id AS gf_id,
   WD.gl_vertrieb_id AS gl_id,
   WD.glv_land_id AS glv_id
  FROM kfl_production_dbp_msi_data.wup_denorm_1 AS WD
   INNER JOIN kfl_production_dbp_data.wup_1 AS WP ON WD.mandant_id = WP.mandant_id AND WD.wup_id = WP.wup_id
  WHERE WP.nb_id IN (- 1, 0)
   AND WD.glv_land_id > 0), MA_BASIS AS (SELECT MAS.mandant_id,
   MAS.ma_id,
   LMA.ma_funktion_id,
   LOWER(MAS.ma_ldap) AS ma_ldap,
   MAS.ma_vorname,
   MAS.ma_name,
   MAS.email
  FROM kfl_production_dbp_data.ma_spr_zu_1 AS MAS
   INNER JOIN kfl_production_dbp_data.l_ma_1 AS LMA ON MAS.ma_id = LMA.ma_id AND MAS.mandant_id = LMA.mandant_id
  WHERE MAS.spr_id = 22), ZENTRAL_USER AS (SELECT a1 AS rolle,
   a2 AS user_vt_id,
   a3 AS user_vt_vorname,
   a4 AS user_vt_name
  FROM (SELECT '900 SIT' AS a1,
      'adminkis' AS a2,
      'Funktionsuser' AS a3,
      'SIT' AS a4
     UNION ALL
     SELECT '900 SIT',
      'ssch0611',
      'Stefan',
      'Schmidt'
     UNION ALL
     SELECT '900 SIT',
      'tekin',
      'Fikri',
      'Tekin'
     UNION ALL
     SELECT '900 SIT',
      'moreno_copad',
      'Florian',
      'Moreno Copado'
     UNION ALL
     SELECT '900 SIT',
      'zemanns',
      'Simon',
      'Zemann'
     UNION ALL
     SELECT '100 VT',
      'mste1112',
      'Marco',
      'Steppe'
     UNION ALL
     SELECT '100 VT',
      'aber1906',
      'Andre',
      'Bertelmann'
     UNION ALL
     SELECT '100 VT',
      'rhaa0505',
      'Ramon',
      'Haase'
     UNION ALL
     SELECT '100 VT',
      'hkoc01101',
      'Heiko',
      'Koch'
     UNION ALL
     SELECT '100 VT',
      'gwei2601',
      'Gregor',
      'Weigel'
     UNION ALL
     SELECT '100 VT',
      'cmet1702',
      'Christine',
      'Metzger'
     UNION ALL
     SELECT '100 VT',
      'ssch06114',
      'Stefan',
      'Schmalzhaf'
     UNION ALL
     SELECT '100 VT',
      'ddor2012',
      'Dennis',
      'Dorn'
     UNION ALL
     SELECT '100 VT',
      'djan1111',
      'Daniela',
      'Janak'
     UNION ALL
     SELECT '100 VT',
      'jcre0604',
      'Jill',
      'Cremer'
     UNION ALL
     SELECT '100 VT',
      'tdie0803',
      'Tom',
      'Dienewald'
     UNION ALL
     SELECT '100 VT',
      'teve2004',
      'Torsten',
      'Evers'
     UNION ALL
     SELECT '100 VT',
      'akal23051',
      'Andrea',
      'Kalinowsky'
     UNION ALL
     SELECT '200 CO/VW ',
      'jlei3005',
      'Jessica',
      'Leibel'
     UNION ALL
     SELECT '200 CO/VW ',
      'msch29125',
      'Maren',
      'Schoettke'
     UNION ALL
     SELECT '200 CO/VW ',
      'jwal0602',
      'Johann',
      'Walger'
     UNION ALL
     SELECT '200 CO/VW ',
      'nsch11101',
      'Nico',
      'Scheuber'
     UNION ALL
     SELECT '200 CO/VW ',
      'nroc1904',
      'Nicole',
      'Rockstroh') AS t69), USER_WUP AS (SELECT LOWER(user_id) AS user_vt_id,
   mandant_id,
   wup_id
  FROM kfl_production_dbp_msi_data.user_wup_zu_1) (SELECT *
  FROM (((((SELECT '010 HL_1' AS rolle,
          LOWER(land_id || CAST(wup_id AS STRING) || 'hl_1') AS user_vt_id,
          'Filiale HL_1 ' AS user_vt_name,
            UPPER(land_id || ' ' || CAST(wup_id AS STRING)) || ' ' || wup_standort AS user_vt_vorname,
          mandant_id,
          wup_id
         FROM WUP_BASIS AS wup_1
         UNION DISTINCT
         SELECT '020 VKL_1',
          vkl.ma_ldap AS user_vt_id,
          vkl.ma_name AS user_vt_name,
          vkl.ma_vorname AS user_vt_vorname,
          wup.mandant_id,
          wup.wup_id
         FROM WUP_BASIS AS wup_1
          LEFT JOIN MA_BASIS AS vkl_1 ON wup.mandant_id = vkl.mandant_id AND wup.vkl_id = vkl.ma_id)
        UNION DISTINCT
        SELECT '030 GF_1',
         gf.ma_ldap AS user_vt_id,
         gf.ma_name AS user_vt_name,
         gf.ma_vorname AS user_vt_vorname,
         wup.mandant_id,
         wup.wup_id
        FROM WUP_BASIS AS wup_1
         LEFT JOIN MA_BASIS AS gf_1 ON wup.mandant_id = gf.mandant_id AND wup.gf_id = gf.ma_id)
       UNION DISTINCT
       SELECT '040 GL',
        gl.ma_ldap AS user_vt_id,
        gl.ma_name AS user_vt_name,
        gl.ma_vorname AS user_vt_vorname,
        wup.mandant_id,
        wup.wup_id
       FROM WUP_BASIS AS wup_1
        LEFT JOIN MA_BASIS AS gl ON wup.mandant_id = gl.mandant_id AND wup.gl_id = gl.ma_id)
      UNION DISTINCT
      SELECT '050 GLV',
       glv.ma_ldap AS user_vt_id,
       glv.ma_name AS user_vt_name,
       glv.ma_vorname AS user_vt_vorname,
       wup.mandant_id,
       wup.wup_id
      FROM WUP_BASIS AS wup_1
       LEFT JOIN MA_BASIS AS glv ON wup.mandant_id = glv.mandant_id AND wup.glv_id = glv.ma_id)
     UNION DISTINCT
     SELECT zen.rolle,
      zen.user_vt_id,
      zen.user_vt_name,
      zen.user_vt_vorname,
      uwz.mandant_id,
      uwz.wup_id
     FROM ZENTRAL_USER AS zen
      INNER JOIN USER_WUP AS uwz ON zen.user_vt_id = uwz.user_vt_id));
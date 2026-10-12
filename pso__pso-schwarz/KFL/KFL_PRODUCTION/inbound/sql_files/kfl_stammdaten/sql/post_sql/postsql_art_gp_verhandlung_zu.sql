/****************  QUELLSYSTEM_ID = 1: art_gp_nm_zu_per     ***************************/
INSERT  INTO DBP_DATA.art_gp_verhandlung_zu 
(mandant_id,gp_id, art_id,IVN_GRUPPE_ID,IVN_VERHANDLUNGS_CLUSTER_ID,IVN_SORTIMENTSGRUPPE_ID,QUELLSYSTEM_ID, td_insert)

SELECT a.mandant_id, a.gp_id, a.art_id, -1,-1,-1,a.QUELLSYSTEM_ID, CURRENT_TIMESTAMP 
  FROM (
        SELECT a.mandant_id, a.gp_id, a.art_id, l.QUELLSYSTEM_ID 
          FROM DBP_DATA.ART_GP_NM_ZU_PER a
          JOIN DBP_DATA.l_QUELLSYSTEM l
            ON a.mandant_id = l.mandant_id 
          LEFT JOIN DBP_DATA.art_gp_verhandlung_zu g
            ON a.mandant_id = g.mandant_id
           AND a.art_id= g.art_id 
           AND a.gp_id= g.gp_id 
         WHERE l.QUELLSYSTEM_BEZ='DBP_DATA.ART_GP_NM_ZU_PER'
           AND g.mandant_id is null
           AND a.gp_id is not null
         GROUP BY 1,2,3,4
       ) a 
;


/****************  QUELLSYSTEM_BEZ: ART_GP_ZU_PER    ***************************/
/*INSERT  INTO DBP_DATA.art_gp_verhandlung_zu 
(mandant_id,gp_id, art_id,IVN_GRUPPE_ID,IVN_VERHANDLUNGS_CLUSTER_ID,IVN_SORTIMENTSGRUPPE_ID,QUELLSYSTEM_ID, td_insert)

SELECT a.mandant_id, a.gp_id, a.art_id, -1,-1,-1,a.QUELLSYSTEM_ID, CURRENT_TIMESTAMP 
  FROM (
        SELECT a.mandant_id, a.gp_id, a.art_id, l.QUELLSYSTEM_ID 
          FROM DBP_DATA.ART_GP_ZU_PER a
          JOIN DBP_DATA.l_QUELLSYSTEM l
            ON a.mandant_id = l.mandant_id 
          LEFT JOIN DBP_DATA.art_gp_verhandlung_zu g
            ON a.mandant_id = g.mandant_id
           AND a.art_id= g.art_id 
           AND a.gp_id= g.gp_id 
         WHERE l.QUELLSYSTEM_BEZ='DBP_DATA.ART_GP_ZU_PER'
           AND g.mandant_id is null
           AND a.gp_id is not null
         GROUP BY 1,2,3,4
       ) a 
;
*/
/****************  QUELLSYSTEM_BEZ: BESCH_RECH_DET_KONT  DE  ***************************/
INSERT  INTO DBP_DATA.art_gp_verhandlung_zu 
(mandant_id,gp_id, art_id,IVN_GRUPPE_ID,IVN_VERHANDLUNGS_CLUSTER_ID,IVN_SORTIMENTSGRUPPE_ID,QUELLSYSTEM_ID, td_insert)

   SELECT a.mandant_id, a.gp_id, a.art_id, -1,-1,-1,a.QUELLSYSTEM_ID, CURRENT_TIMESTAMP 
  FROM (
        SELECT brdk.mandant_id, br.gp_id   , awzp.art_id, l.QUELLSYSTEM_ID 
          FROM DBP_DATA.BESCH_RECH_DET_KONT brdk
          LEFT OUTER JOIN DBP_DATA.besch_rech br
            ON brdk.mandant_id = br.mandant_id
           AND brdk.gj = br.gj
           AND brdk.rech_beleg_id = br.rech_beleg_id
   
          LEFT OUTER JOIN DBP_DATA.art_wg_zu_per awzp
            ON brdk.wg_id *(-1000) = awzp.art_id
           AND brdk.mandant_id = awzp.mandant_id
           AND brdk.arthiertyp_id = awzp.arthiertyp_id
    
          JOIN DBP_DATA.l_QUELLSYSTEM l
            ON brdk.mandant_id = l.mandant_id 
    
          LEFT JOIN DBP_DATA.art_gp_verhandlung_zu g
            ON brdk.mandant_id = g.mandant_id
           AND awzp.art_id= g.art_id 
           AND br.gp_id= g.gp_id 
   
         WHERE l.QUELLSYSTEM_BEZ='DBP_DATA.BESCH_RECH_DET_KONT'
           AND g.mandant_id is null
           AND br.gp_id is not null
           AND brdk.mandant_id=1
           AND awzp.dat_bis = '9999-12-31' 
           AND RIGHT(brdk.sachkonto_id,6) IN
                   (
                   '314602'
                   ,'314603'
                   ,'314604'
                   ,'314605'
                   ,'314606'
                   ,'314607'
                   ,'314608'
                   ,'314609'
                   ,'314610'
                   ,'314611'
                   ,'314612'
                   ,'314616'
                   ,'314617'
                   ,'314621'
                   ,'314622'
                   ,'314623'
                   ,'314624'
                   )
          AND brdk.row_grund_id IN (
                   '100'
                   ,'101'
                   ,'103'
                   ,'104'
                   ,'105'
                   ,'106'
                   ,'107'
                   ,'108'
                   ,'109'
                   ,'110'
                   ,'111'
                   ,'112'
                   ,'114'
                   ,'116'
                   ,'119'
                   ,'120'
                   ,'142'
                   ,'160'
                   ,'161'
                   ,'199'
                   )         
        GROUP BY 1,2,3,4
       ) a 
 ;

/****************  QUELLSYSTEM_BEZ: BESCH_RECH_DET_KONT  KMO  ***************************/
INSERT  INTO DBP_DATA.art_gp_verhandlung_zu 
(mandant_id,gp_id, art_id,IVN_GRUPPE_ID,IVN_VERHANDLUNGS_CLUSTER_ID,IVN_SORTIMENTSGRUPPE_ID,QUELLSYSTEM_ID, td_insert)

   SELECT a.mandant_id, a.gp_id, a.art_id, -1,-1,-1,a.QUELLSYSTEM_ID, CURRENT_TIMESTAMP 
  FROM (
        SELECT brdk.mandant_id, br.gp_id   , -2 as art_id, l.QUELLSYSTEM_ID 
          FROM DBP_DATA.BESCH_RECH_DET_KONT brdk
          LEFT OUTER JOIN DBP_DATA.besch_rech br
            ON brdk.mandant_id = br.mandant_id
           AND brdk.gj = br.gj
           AND brdk.rech_beleg_id = br.rech_beleg_id
   
          LEFT OUTER JOIN DBP_DATA.art_per ap
            ON brdk.mandant_id = ap.mandant_id
           AND br.dat_buch BETWEEN ap.dat_von-1 AND ap.dat_bis-1
           AND -2 = ap.art_id

          JOIN DBP_DATA.mandant  m
            ON brdk.mandant_id= m.mandant_id

          JOIN DBP_DATA.l_QUELLSYSTEM l
            ON brdk.mandant_id = l.mandant_id 
    
          LEFT JOIN DBP_DATA.art_gp_verhandlung_zu g
            ON brdk.mandant_id = g.mandant_id
           AND g.art_id = -2
           AND br.gp_id= g.gp_id 
   
         WHERE l.QUELLSYSTEM_BEZ='DBP_DATA.BESCH_RECH_DET_KONT'
           AND g.mandant_id is null
           AND br.gp_id is not null
           AND ((brdk.mandant_id IN (2,3,5,6) AND sachkonto_id IN ('R097761', 'R097762', 'R097763') )
               OR 
                (brdk.mandant_id IN (7,8)     AND sachkonto_id IN ('0000097761', '0000097762', '0000097763') )
                )
        GROUP BY 1,2,3,4
       ) a 
 ;


/****************  QUELLSYSTEM_BEZ: EK_INFOSATZ    ***************************/
INSERT  INTO DBP_DATA.art_gp_verhandlung_zu 
(mandant_id,gp_id, art_id,IVN_GRUPPE_ID,IVN_VERHANDLUNGS_CLUSTER_ID,IVN_SORTIMENTSGRUPPE_ID,QUELLSYSTEM_ID, td_insert)

SELECT a.mandant_id, a.gp_id, a.art_id, -1,-1,-1,a.QUELLSYSTEM_ID, CURRENT_TIMESTAMP 
  FROM (
        SELECT a.mandant_id, a.gp_id, a.art_id, l.QUELLSYSTEM_ID 
          FROM DBP_DATA.EK_INFOSATZ a
          JOIN DBP_DATA.l_QUELLSYSTEM l
            ON a.mandant_id = l.mandant_id 
          LEFT JOIN DBP_DATA.art_gp_verhandlung_zu g
            ON a.mandant_id = g.mandant_id
           AND a.art_id= g.art_id 
           AND a.gp_id= g.gp_id 
         WHERE l.QUELLSYSTEM_BEZ='DBP_DATA.EK_INFOSATZ'
           AND g.mandant_id is null
           AND a.gp_id is not null
         GROUP BY 1,2,3,4
       ) a 
;

/****************  QUELLSYSTEM_BEZ: REKL    ***************************/
INSERT  INTO DBP_DATA.art_gp_verhandlung_zu 
(mandant_id,gp_id, art_id,IVN_GRUPPE_ID,IVN_VERHANDLUNGS_CLUSTER_ID,IVN_SORTIMENTSGRUPPE_ID,QUELLSYSTEM_ID, td_insert)

SELECT a.mandant_id, a.gp_id, a.art_id, -1,-1,-1,a.QUELLSYSTEM_ID, CURRENT_TIMESTAMP 
  FROM (
        SELECT a.mandant_id, a.gp_id, a.art_id, l.QUELLSYSTEM_ID 
          FROM DBP_DATA.REKL a
          JOIN DBP_DATA.l_QUELLSYSTEM l
            ON a.mandant_id = l.mandant_id 
          LEFT JOIN DBP_DATA.art_gp_verhandlung_zu g
            ON a.mandant_id = g.mandant_id
           AND a.art_id= g.art_id 
           AND a.gp_id= g.gp_id 
         WHERE l.QUELLSYSTEM_BEZ='DBP_DATA.REKL'
           AND g.mandant_id is null
           AND a.gp_id is not null
         GROUP BY 1,2,3,4
       ) a 
;


/****************  QUELLSYSTEM_BEZ: WEWA    ***************************/
INSERT  INTO DBP_DATA.art_gp_verhandlung_zu 
(mandant_id,gp_id, art_id,IVN_GRUPPE_ID,IVN_VERHANDLUNGS_CLUSTER_ID,IVN_SORTIMENTSGRUPPE_ID,QUELLSYSTEM_ID, td_insert)

SELECT a.mandant_id, a.gp_id, a.art_id, -1,-1,-1,a.QUELLSYSTEM_ID, CURRENT_TIMESTAMP 
  FROM (
        SELECT a.mandant_id, a.gp_id, a.art_id, l.QUELLSYSTEM_ID 
          FROM DBP_DATA.WEWA a
          JOIN DBP_DATA.l_QUELLSYSTEM l
            ON a.mandant_id = l.mandant_id 
          LEFT JOIN DBP_DATA.art_gp_verhandlung_zu g
            ON a.mandant_id = g.mandant_id
           AND a.art_id= g.art_id 
           AND a.gp_id= g.gp_id 
         WHERE l.QUELLSYSTEM_BEZ='DBP_DATA.WEWA'
           AND g.mandant_id is null
           AND a.gp_id is not null
         GROUP BY 1,2,3,4
       ) a 
;


/****************  QUELLSYSTEM_BEZ: BSCH_RECH_DET    ***************************/
INSERT  INTO DBP_DATA.art_gp_verhandlung_zu 
(mandant_id,gp_id, art_id,IVN_GRUPPE_ID,IVN_VERHANDLUNGS_CLUSTER_ID,IVN_SORTIMENTSGRUPPE_ID,QUELLSYSTEM_ID, td_insert)

SELECT a.mandant_id, a.gp_id, a.art_id, -1,-1,-1,a.QUELLSYSTEM_ID, CURRENT_TIMESTAMP 
  FROM (
        SELECT a.mandant_id, a.gp_id, a.art_id, l.QUELLSYSTEM_ID 
          FROM DBP_DATA.BSCH_RECH_DET a
          JOIN DBP_DATA.l_QUELLSYSTEM l
            ON a.mandant_id = l.mandant_id 
          LEFT JOIN DBP_DATA.art_gp_verhandlung_zu g
            ON a.mandant_id = g.mandant_id
           AND a.art_id= g.art_id 
           AND a.gp_id= g.gp_id 
         WHERE l.QUELLSYSTEM_BEZ='DBP_DATA.BSCH_RECH_DET'
           AND g.mandant_id is null
           AND a.gp_id is not null
         GROUP BY 1,2,3,4
       ) a 
;

CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BUCH_WUP_ZU_1
             (
             wup_id
             ,nb_id
             ,mandant_id
             ,bgrp_id
             ,system_id
             )
             AS
                SELECT
v01.wup_id,
                v01.nb_id,
                v01.mandant_id,
                CASE WHEN v01.nb_id=0 AND v01.wup_id
                IN (5560,5670,5730,5700,5550,5540,5710,5650,5690,5720,5610,5660,5620,5590,5580,5600,5680,5530,5640,5570,5630)
                THEN 'GO'
                WHEN v01.nb_id=0 AND v01.wup_id
                IN (5130,5510,5220,5350,5470,5080,5280,5410,5290,5480,5450,5210,5250,5170,5090,5260,5500,5150,5110,
                5420,5370,5330,5320,5390,5230,5430,5120,5460,5300,5200,5520,5190,5180,5270,5380,5140,5340)
                THEN 'GW'
                WHEN v01.nb_id=0 AND v01.vw_id=1 THEN 'O'
                WHEN v01.nb_id=0 AND v01.vw_id=2 THEN 'W'
                WHEN v01.nb_id=0 AND v01.vw_id=3 THEN 'N'
                WHEN v01.nb_id=0 AND v01.wup_id IN (1260,1180,1210,1240,1020,1140,1170,1280) THEN 'CO'
                WHEN v01.nb_id=0 AND v01.wup_id IN (1010,1070,1030,1090,1000,1050,1040,1100,1060,1080) THEN 'CW'
                WHEN zu_id=2 THEN 'ZW'
                WHEN zu_id =1 THEN 'ZO'
                WHEN zu_id=3 THEN 'ZN'
                WHEN v01.nb_id=0 AND v01.wup_id IN(5920,5950) THEN 'EH' ELSE 'N/A' END AS bgrp_id,
                7
                FROM dbp_view.v_wup_1 v01
                LEFT OUTER JOIN dbp_msi_view_rpw.mv_vz_zuordnung_1 v02
                ON
                v01.wup_id=v02.wup_id
                WHERE v01.mandant_id=1
                AND v01.nb_id IN (0,-111);
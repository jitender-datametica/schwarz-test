CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_CLUSTER_DAUER_SPR_ZU_2(
	CLUSTER_DAUER_ID,
	CLUSTER_DAUER_DESC
) AS
    --2025-09-30, dknop, AP0269651, SPEC0329583, initial
    --2025-01-08, dknop, adding 'Mid-Week'
   SELECT
   1 AS cluster_dauer_id
    ,'1-Tages-Aktion_2 Montag' AS cluster_dauer_desc
    UNION SELECT
2 AS cluster_dauer_id
    ,'1-Tages-Aktion_2 Dienstag' AS cluster_dauer_desc
    UNION SELECT
3 AS cluster_dauer_id
    ,'1-Tages-Aktion_2 Mittwoch' AS cluster_dauer_desc
    UNION SELECT
4 AS cluster_dauer_id
    ,'1-Tages-Aktion_2 Donnerstag' AS cluster_dauer_desc
    UNION SELECT
5 AS cluster_dauer_id
    ,'1-Tages-Aktion_2 Freitag' AS cluster_dauer_desc
    UNION SELECT
6 AS cluster_dauer_id
    ,'1-Tages-Aktion_2 Samstag' AS cluster_dauer_desc
    UNION SELECT
7 AS cluster_dauer_id
    ,'1-Tages-Aktion_2 Sonntag' AS cluster_dauer_desc
    UNION SELECT
8 AS cluster_dauer_id
    ,'Wochenstart' AS cluster_dauer_desc
    UNION SELECT
9 AS cluster_dauer_id
    ,'Wochenende' AS cluster_dauer_desc
    UNION SELECT
10 AS cluster_dauer_id
    ,'Wochenwerbung' AS cluster_dauer_desc
    UNION SELECT
11 AS cluster_dauer_id
    ,'Aktion_2 > 9 Tage' AS cluster_dauer_desc
    UNION SELECT
12 AS cluster_dauer_id
    ,'Mid-Week' AS cluster_dauer_desc
    UNION SELECT
99 AS cluster_dauer_id
    ,'Sonstiges' AS cluster_dauer_desc
   
    ;
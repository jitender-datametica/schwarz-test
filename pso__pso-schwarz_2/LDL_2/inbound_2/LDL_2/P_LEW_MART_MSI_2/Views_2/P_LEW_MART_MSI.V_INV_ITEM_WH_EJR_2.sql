/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  23.10.2017    Proch,Marika             Anpassung WH_id zu src_wh_id
#  1.2  06.11.2017    proch, Marika            Anpassung src_wh_id zu wh_id
#  1.3  15.11.2017    Mittler,Patrick          Aenderung WAWI-Zugriff auf AC-Layer
#  1.4  15.11.2017    Wieber,Harald            Release 1.1
#  1.5  20.11.2017    Arnold,Arne              Datenbankzugriff von _AC zu ohne AC geändert.
#  1,6  06.12.2017    Mittler,Patrick          Anpassung Währungsumrechner (Wawi-Seite).
#  1.7  24.07.2018    Michael Ueding           Referenz Item_2 Mapping geaendert
#  2.0  29.07.2021    Tris Bazliff             Initial
#                                              20210701_2876_Rohertragsletter_perf_ddl2
#                                              https://jira.schwarz/browse/REP2-9836
#  3.0  2021-08-02    Tris Bayliff             Switch to LEW_MART_MSI database
#                                              20210730_2897_Rohertragsletter_perf_ddl3
#                                              https://jira.schwarz/browse/REP2-10035
#  4.0  2021-09-29    Tris Bayliff             Change for SnowFlake
#                                              20210730_2897_Rohertragsletter_perf_ddl3
#                                              https://jira.schwarz/browse/REP2-10035
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_INV_ITEM_WH_EJR_2
(
  CLIENT_ID
, WH_ID
, INV_ID
, INV_START_DATE
, INV_END_DATE
, ITEM_ID
, VAL_RTL_EJR_ASIS
, VAL_RTL_NET_EJR_ASIS
, VAL_RETURN_EJR_ASIS
, VAL_RETURN_NET_EJR_ASIS
, CURRENCY_ISO_CD
)
AS
SELECT
  CLIENT_ID
, WH_ID
, INV_ID
, INV_START_DATE
, INV_END_DATE
, ITEM_ID
, VAL_RTL_EJR_ASIS
, VAL_RTL_NET_EJR_ASIS
, VAL_RETURN_EJR_ASIS
, VAL_RETURN_NET_EJR_ASIS
, CURRENCY_ISO_CD
FROM P_LEW_MART_MSI.T_INV_ITEM_WH_EJR_2
;
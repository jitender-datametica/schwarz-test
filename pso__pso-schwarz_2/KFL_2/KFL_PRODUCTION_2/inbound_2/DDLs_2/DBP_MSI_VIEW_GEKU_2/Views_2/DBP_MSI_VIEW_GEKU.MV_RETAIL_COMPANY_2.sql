CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_RETAIL_COMPANY_2(
	EXT_RETAIL_COMPANY_ID,
	EXT_SYSTEM_NAME,
	MANDANT_ID,
	RETAIL_COMPANY_CODE,
	RETAIL_COMPANY_NAME,
	COMPETITOR_FG,
	SEC_KZ
) AS
--08.03.2023 twie: SPEC0170810 Join über retail_store_2 zu retail_store_distance_2 als Filter
--                 es sollen nur companies angezeigt werden, zu denen es auch stores in der retail_store_distance_2 Tabelle gibt (vgl. VIS)
--21.11.2024 twie: SPEC0267631 PK wird geändert von retail_company_sid auf ext_retail_company_id, store analog
--27.11.2024 twie: SPEC0267631 Felder mit sid werden komplett entfernt
--04.12.2024 pkra: SPEC0260453 SEC KZ column added with value 2 for security reasons in google report

SELECT   v01.ext_retail_company_id
        ,v01.ext_system_name
        ,v01.mandant_id
        ,v01.retail_company_code
        ,v01.retail_company_name
        ,v01.competitor_fg
        , 2::BYTEINT AS sec_kz

FROM dbp_view.v_retail_company_2 v01

INNER JOIN
(
	SELECT 
	v21.ext_retail_company_id
	FROM dbp_view.v_retail_store_2 v21

	INNER JOIN dbp_view.v_retail_store_distance_2 v22
	ON v21.ext_store_id = v22.ext_store_id

	GROUP BY v21.ext_retail_company_id

) v02
ON v01.ext_retail_company_id = v02.ext_retail_company_id
;
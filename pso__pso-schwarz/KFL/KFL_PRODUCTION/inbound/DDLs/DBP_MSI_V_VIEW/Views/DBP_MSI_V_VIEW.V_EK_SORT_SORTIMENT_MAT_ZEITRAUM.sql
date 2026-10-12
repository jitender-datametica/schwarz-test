CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_EK_SORT_SORTIMENT_MAT_ZEITRAUM AS 
    SELECT 
        kjmo_sort,
        kjwo_von,
        kjwo_bis,
        dat_von,
        dat_bis,
        monate_anz

FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM ;
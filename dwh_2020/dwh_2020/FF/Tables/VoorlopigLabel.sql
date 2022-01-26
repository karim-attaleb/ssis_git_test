CREATE TABLE [FF].[VoorlopigLabel] (
    [VoorlopigLabelID]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DiersoortID]          NVARCHAR (15) NOT NULL,
    [Jaartal]              SMALLINT      NOT NULL,
    [KboNummer]            NVARCHAR (50) NULL,
    [AfschotPlanNummer]    NVARCHAR (15) NOT NULL,
    [VolgnummerLabelFrom]  INT           NOT NULL,
    [VolgnummerLabelUntil] INT           NOT NULL,
    [SoftDeleted]          BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]           ROWVERSION    NOT NULL,
    CONSTRAINT [PK_VoorlopigLabel] PRIMARY KEY CLUSTERED ([VoorlopigLabelID] ASC)
);


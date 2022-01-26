CREATE TABLE [GIS].[LocatiePuntPrecisieType] (
    [LocatiePuntPrecisieTypeID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Beschrijving]              VARCHAR (100) NULL,
    [Straal]                    INT           NULL,
    [IsBuffer]                  BIT           NOT NULL,
    [SoftDeleted]               BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]                ROWVERSION    NOT NULL,
    CONSTRAINT [PK_PuntLocatieType] PRIMARY KEY CLUSTERED ([LocatiePuntPrecisieTypeID] ASC)
);


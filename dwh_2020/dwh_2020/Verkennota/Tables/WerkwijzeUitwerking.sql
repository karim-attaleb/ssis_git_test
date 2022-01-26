CREATE TABLE [Verkennota].[WerkwijzeUitwerking] (
    [WerkwijzeUitwerkingID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [WerkwijzeUitwerkingTypeID] NVARCHAR (15)  NOT NULL,
    [IndieningID]               INT            NOT NULL,
    [Description]               NVARCHAR (MAX) NULL,
    [SoftDeleted]               BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([WerkwijzeUitwerkingID] ASC),
    CONSTRAINT [FK_WerkwijzeUitwerkingType_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID]),
    CONSTRAINT [FK_WerkwijzeUitwerkingType_WerkwijzeUitwerkingType] FOREIGN KEY ([WerkwijzeUitwerkingTypeID]) REFERENCES [Verkennota].[WerkwijzeUitwerkingType] ([WerkwijzeUitwerkingTypeID])
);


CREATE TABLE [IR].[PartijAdres] (
    [PartijAdresID]     INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningPartijID] INT              NOT NULL,
    [PartijAdresTypeID] NVARCHAR (15)    NOT NULL,
    [Straatnaam]        NVARCHAR (50)    NULL,
    [Huisnummer]        NVARCHAR (15)    NULL,
    [Busnummer]         NVARCHAR (15)    NULL,
    [GemeenteNaam]      NVARCHAR (100)   NULL,
    [GemeentePostCode]  NVARCHAR (15)    NULL,
    [GemeenteNisCode]   NVARCHAR (15)    NULL,
    [LandID]            NVARCHAR (5)     NULL,
    [CrabObjectID]      NVARCHAR (15)    NULL,
    [CrabObjectTypeID]  NVARCHAR (15)    NULL,
    [MagdaAdresFlag]    BIT              DEFAULT ((0)) NULL,
    [SoftDeleted]       BIT              DEFAULT ((0)) NOT NULL,
    [RowVersion]        ROWVERSION       NOT NULL,
    [PartijAdresGUID]   UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_PartijAdres] PRIMARY KEY CLUSTERED ([PartijAdresID] ASC),
    CONSTRAINT [FK_Partij_PartijAdresID] FOREIGN KEY ([IndieningPartijID]) REFERENCES [IR].[IndieningPartij] ([IndieningPartijID]),
    CONSTRAINT [FK_PartijAdres_CrabObjectTypeID] FOREIGN KEY ([CrabObjectTypeID]) REFERENCES [GIS].[CrabObjectType] ([CrabObjectTypeID]),
    CONSTRAINT [FK_PartijAdres_PartijAdresTypeID] FOREIGN KEY ([PartijAdresTypeID]) REFERENCES [IR].[PartijAdresType] ([PartijAdresTypeID])
);


CREATE TABLE [Verkennota].[Vegetatie] (
    [VegetatieId]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]     INT            NOT NULL,
    [VegetatieTypeID] NVARCHAR (15)  NOT NULL,
    [Beschrijving]    NVARCHAR (MAX) NULL,
    [SoftDeleted]     BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]      ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([VegetatieId] ASC),
    CONSTRAINT [FK_Vegetatie_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID]),
    CONSTRAINT [FK_Vegetatie_VegetatieType] FOREIGN KEY ([VegetatieTypeID]) REFERENCES [Verkennota].[VegetatieType] ([VegetatieTypeID])
);


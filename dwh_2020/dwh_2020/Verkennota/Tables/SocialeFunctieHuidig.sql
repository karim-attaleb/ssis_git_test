CREATE TABLE [Verkennota].[SocialeFunctieHuidig] (
    [SocialeFunctieHuidigId]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]                INT            NOT NULL,
    [SocialeFunctieHuidigTypeID] NVARCHAR (15)  NOT NULL,
    [Beschrijving]               NVARCHAR (MAX) NULL,
    [SoftDeleted]                BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                 ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([SocialeFunctieHuidigId] ASC),
    CONSTRAINT [FK_SocialeFunctieHuidig_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID]),
    CONSTRAINT [FK_SocialeFunctieHuidig_SocialeFunctieHuidigType] FOREIGN KEY ([SocialeFunctieHuidigTypeID]) REFERENCES [Verkennota].[SocialeFunctieHuidigType] ([SocialeFunctieHuidigTypeID])
);


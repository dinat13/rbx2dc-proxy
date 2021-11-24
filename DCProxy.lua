--[[
    Made by dinat13 (950746070)

    [Documentation]

    Start your script by 
    "local DCProxy = require(game.ServerScriptService.DCProxy)
    
    DCProxy.setup('YOUR_WEBHOOK_LINK', select between true and false)"

    More examples available on GitHub (https://github.com/dinat13/rbx2dc-proxy/)

    Here are all the functions
    
    -- Send a message
        local Message = 'Hello world!'
        DCProxy:SendWebhookMessage(Message)

    -- Send an embed with fields
        local Player = game.Players:WaitForChild('dinat13')
        local Message = 'This is an embed'
        local Fields = DCProxy.newFields({
            {
                Name = 'Version',
                Value = '1.0.0', -- Make sure this is a string!!!
                Inline = true,
            },
            {
                Name = 'Project',
                Value = 'My webhooks',
                Inline = true,
            },
            {
                Name = 'My life!',
                Value = 'My name is x, and I live in y.',
                Inline = false
            }
        })

        local Embed = DCProxy.newEmbed( -- sadly there is no way at moment to separate the settings
            'Title of my embed...', -- title
            'This is the description of my embed', -- description
            'https://www.roblox.com/home', -- url
            os.time(), -- timestamp
            000000, -- colour in hex
            'A footer', -- footer text
            game.Players:GetThumbnailAsync(Player.UserId), -- footer image
            'https://www.yourwebsite.org/image.png', -- image
            'https://www.yourwebsite.org/thumbnail.jpeg', -- thumbnail,
            'Dinat' -- author's name
            game.Players:GetThumbnailAsync(Player.UserId), -- author's icon
            'https://www.yourwebsite.org/home', -- author's url
            Fields -- the fields
        )

        DCProxy:SendWebhookMessage(Embed, Message)

    -- Get a message
        local MessageId = '12345678942069' -- make sure this is a string
        local Message = DCProxy:GetWebhookMessage(MessageId)

        print(Message)

    -- Edit a message
        local MessageId = '12345678942069' -- make sure this is a string
        local NewMessage = 'This message is modified!'

        DCProxy:EditWebhookMessage(MessageId, NewMessage)

    -- Delete a message
        local MessageId = '12345678942069' -- make sure this is a string

        DCProxy:DeleteWebhookMessage(MessageId)


    And that's all! More functions might come in the future...

    
    ]]

local HttpService = game:GetService('HttpService');
local DCProxy = {};

DCProxy.newFields = function(fields)
    local newFields = {}
    if type(fields) == 'table' then
        for _, field in pairs(fields) do
            local newField = { ['name'] = field.Name, ['value'] = field.Value, ['inline'] = field.Inline };
            
            table.insert(newFields, newField);
        end;

        return newFields;
    else
        warn('Rbx2DC-proxy: The fields are not in an array, please refer to the tutorial!');
    end;
end;

DCProxy.newEmbed = function(title: string, desc: string, url: string, timestamp: number, color, footerText: string, footerIcon: string, image: string, thumbnail: string, authorText: string, authorIcon: string, authorUrl: string, fields)
    return embedArray = { ['title'] = title, desc, ['url'] = url, ['timestamp'] = timestamp, ['color'] = color, ['footer'] = { ['text'] = footerText, ['icon_url'] = footerIcon }, ['image'] = image, ['thumbnail'] = thumbnail, ['author'] = { ['name'] = authorText, ['url'] = authorUrl, ['icon_url'] = authorIcon }, ['fields'] = fields };
end;

DCProxy.setup = function(WebhookLink: string, Responses: boolean)
    local link;
    if WebhookLink ~= '' and WebhookLink ~= ' ' and WebhookLink then
        link = WebhookLink;

        -- POST a webhook message
        function SendWebhookMessage(Message: string)
            if Message == '' or Message == ' ' or not Message then
                warn('Rbx2DC-proxy: Please enter a message!');
            else
                local Data = HttpService:JSONEncode({ ['data'] = { ['content'] = Message }, ['method'] = 'POST' });

                HttpService:PostAsync(link, Data);
            end;
        end;

        -- POST a webhook embed with a message
        function DCProxy:SendWebhookEmbed(Embed, Message: string)
            if type(Embed) == 'table' then
                if Embed then
                    if Embed[1] and type(Embed[1]) == 'string' then
                        if Embed and Message and Message ~= '' and Message ~= ' ' then
                            local Data = HttpService:JSONEncode({ ['data'] = { ['content'] = Message, ['embeds'] = Embed }, ['method'] = 'POST' });

                            HttpService:PostAsync(link, Data);
                        else
                            local Data = HttpService:JSONEncode({ ['data'] = { ['embeds'] = Embed }, ['method'] = 'POST' });

                            HttpService:PostAsync(link, Data);
                        end;
                    else
                        warn('Rbx2DC-proxy: At least a title is needed, please specify one!');
                    end;
                else
                    warn('Rbx2DC-proxy: There is no embed, please specify one!');
                end;
            else
                warn('Rbx2DC-proxy: The embed is not correct, please refer to the tutorial!');
            end;
        end;

        -- GET webhook message
        function DCProxy:GetWebhookMessage(MessageId: string)
            if MessageId then
                local Data = HttpService:GetAsync(link..'/'..MessageId);
                Data = HttpService:JSONDecode(Data);

                return Data;
            else
                warn('Rbx2DC-proxy: Please specify a message id!');
            end;
        end;

        -- PATCH webhook message
        function DCProxy:EditWebhookMessage(MessageId: string, Message: string)
            if MessageId and Message then
                local Data = HttpService:JSONEncode({ ["data"] = { ['content'] = Message }, ['method'] = 'PATCH' });

                HttpService:PostAsync(link..'/'..MessageId, Data);
            else
                ('Rbx2DC-proxy: There is no message id/message content, please specify one!');
            end;
        end;

        -- DELETE webhook message
        function DCProxy:DeleteWebhookMessage(MessageId: string)
            if MessageId then
                local Data = HttpService:JSONEncode({ ['method'] = 'DELETE' });
                
                HttpService:PostAsync(link..'/'..MessageId, Data);
            else
                ('Rbx2DC-proxy: There is no message id, please specify one!');
            end;
        end;
    end;
end;

return DCProxy;

###
# Copyright (C) 2014-2015 Taiga Agile LLC <taiga@taiga.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: attchment.controller.spec.coffee
###

class AttachmentController
    @.$inject = [
        'tgAttachmentsService',
        '$translate'
    ]

    constructor: (@attachmentsService, @translate) ->
        @.form = {}
        @.form.description = @.attachment.get('description')
        @.form.is_deprecated = @.attachment.get('is_deprecated')

        @.title = @translate.instant("ATTACHMENT.TITLE", {
                            fileName: @.attachment.get('name'),
                            date: moment(@.attachment.get('created_date')).format(@translate.instant("ATTACHMENT.DATE"))
                        })

    editMode: (mode) ->
        @.attachment = @.attachment.set('editable', mode)

    delete: () ->
        @.onDelete({attachment: @.attachment}) if @.onDelete

    save: () ->
        attachment = @.attachment.set('editable', false)

        attachment = attachment.mergeIn(['file'], {
            'description': @.form.description,
            'is_deprecated': !!@.form.is_deprecated
        })


        if @.onUpdate
            @.onUpdate({attachment: attachment}).then (attachment) -> @.attachment = attachment
        else
            @.attachment = attachment

angular.module('taigaComponents').controller('Attachment', AttachmentController)

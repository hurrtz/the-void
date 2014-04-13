module Alerts
    @@alerts = {error: [], note: [], success: []}

    def Alerts.add(severity, message, called_by = nil)
        @@alerts[severity] = [] if !@@alerts.has_key?(severity)
        @@alerts[severity].push({message: message, called_by: called_by})
    end

    def Alerts.error!(message, called_by = nil)
       @@alerts[:error].push({message: message, called_by: called_by})
    end

    def Alerts.note!(message, called_by = nil)
        @@alerts[:note].push({message: message, called_by: called_by})
    end

    def Alerts.success!(message, called_by = nil)
        @@alerts[:success].push({message: message, called_by: called_by})
    end

    def Alerts.get(severity = nil, inline = true)
        if severity.nil?
            _tmp = @@alerts
            @@alerts = {error: [], note: [], success: []}
            _tmp

        elsif @@alerts.key?(severity)
            if inline
                _out = ''

                @@alerts[severity].each do |message|
                    _out += '<br />' + message.to_s
                end

                @@alerts[severity] = []

                _out
            else
                _tmp = @@alerts[severity]
                @@alerts = @@alerts[severity] = []
                _tmp
            end
        end
    end
end
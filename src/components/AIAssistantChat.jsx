import React, { useState } from 'react';
import { X, Send, Bot, Mic, Sparkles, User, CheckCircle2 } from 'lucide-react';

export default function AIAssistantChat({ onClose, activeProperty }) {
  const [messages, setMessages] = useState([
    {
      sender: 'ai',
      text: activeProperty
        ? `Welcome to NEST AI Assistant! Loaded property context for "${activeProperty.title}". Ask me about maintenance costs, construction quality, Vastu orientation, or local area infrastructure!`
        : `Welcome to NEST AI Assistant! Ask me anything about property valuations, budget planning, or neighborhood price trends!`
    }
  ]);
  const [input, setInput] = useState('');
  const [isRecording, setIsRecording] = useState(false);

  const handleSend = () => {
    if (!input.trim()) return;
    const userMsg = input;
    setInput('');
    setMessages((prev) => [...prev, { sender: 'user', text: userMsg }]);

    setTimeout(() => {
      let reply = `Based on NEST market analytics, this property offers strong potential. Would you like me to inspect Vastu ratings or run a legal document check?`;
      if (userMsg.toLowerCase().includes('vastu')) {
        reply = `NEST Vastu Analysis: North-East main entry with kitchen in South-East (Agneya). NEST Vastu Rating: 9.2/10!`;
      } else if (userMsg.toLowerCase().includes('maintenance') || userMsg.toLowerCase().includes('fee')) {
        reply = `Monthly maintenance is estimated at ₹3.50/sqft (~₹6,475/mo), covering 24/7 security, solar grid, and infinity pool.`;
      }
      setMessages((prev) => [...prev, { sender: 'ai', text: reply }]);
    }, 600);
  };

  const handleVoiceSim = () => {
    setIsRecording(true);
    setTimeout(() => {
      setIsRecording(false);
      setInput('Is this property Vastu compliant and what are the maintenance fees?');
    }, 2000);
  };

  return (
    <div className="fixed bottom-4 right-4 z-50 w-full max-w-sm glass-card rounded-2xl border border-amber-500/40 shadow-2xl overflow-hidden flex flex-col h-[480px]">
      {/* Header */}
      <div className="bg-slate-900 p-3.5 border-b border-slate-800 flex items-center justify-between">
        <div className="flex items-center gap-2">
          <div className="w-8 h-8 rounded-lg bg-gradient-to-tr from-amber-500 to-indigo-600 text-white flex items-center justify-center shadow-md">
            <Bot className="w-4 h-4" />
          </div>
          <div>
            <h3 className="font-bold text-white text-sm">NEST AI Copilot</h3>
            <span className="text-[10px] text-emerald-400 font-semibold flex items-center gap-1">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-400 animate-pulse" /> Live Property Context
            </span>
          </div>
        </div>
        <button onClick={onClose} className="text-slate-400 hover:text-white p-1">
          <X className="w-4 h-4" />
        </button>
      </div>

      {/* Message List */}
      <div className="flex-1 p-3 overflow-y-auto space-y-3 bg-slate-950/80 text-xs">
        {messages.map((m, idx) => (
          <div
            key={idx}
            className={`flex items-start gap-2 ${m.sender === 'user' ? 'flex-row-reverse' : ''}`}
          >
            <div
              className={`w-6 h-6 rounded-full flex items-center justify-center text-[10px] ${
                m.sender === 'user' ? 'bg-violet-600 text-white' : 'bg-amber-600 text-white'
              }`}
            >
              {m.sender === 'user' ? <User className="w-3 h-3" /> : <Bot className="w-3 h-3" />}
            </div>
            <div
              className={`max-w-[80%] p-2.5 rounded-xl ${
                m.sender === 'user'
                  ? 'bg-indigo-600 text-white rounded-tr-none'
                  : 'bg-slate-900 border border-slate-800 text-slate-200 rounded-tl-none'
              }`}
            >
              {m.text}
            </div>
          </div>
        ))}

        {isRecording && (
          <div className="flex items-center gap-2 text-amber-400 font-semibold animate-pulse text-[11px] p-2 bg-amber-950/40 rounded-lg">
            <Mic className="w-4 h-4" /> NEST Voice Engine listening...
          </div>
        )}
      </div>

      {/* Input Form */}
      <div className="p-2.5 bg-slate-900 border-t border-slate-800 flex items-center gap-2">
        <button
          onClick={handleVoiceSim}
          className={`p-2 rounded-xl transition-all ${
            isRecording ? 'bg-red-600 text-white animate-bounce' : 'bg-slate-800 text-slate-400 hover:text-white'
          }`}
          title="Voice Search Simulator"
        >
          <Mic className="w-4 h-4" />
        </button>
        <input
          type="text"
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyDown={(e) => e.key === 'Enter' && handleSend()}
          placeholder="Ask NEST AI about this property..."
          className="flex-1 bg-slate-950 border border-slate-800 rounded-xl px-3 py-2 text-xs text-white focus:outline-none focus:border-amber-500"
        />
        <button
          onClick={handleSend}
          className="p-2 rounded-xl bg-gradient-to-r from-amber-600 to-indigo-600 hover:opacity-90 text-white transition-all shadow-md"
        >
          <Send className="w-4 h-4" />
        </button>
      </div>
    </div>
  );
}

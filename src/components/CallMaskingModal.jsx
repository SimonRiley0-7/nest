import React, { useState, useEffect } from 'react';
import { X, PhoneCall, ShieldCheck, Clock, CheckCircle, Volume2, Mic, Lock } from 'lucide-react';

export default function CallMaskingModal({ property, onClose }) {
  const [session, setSession] = useState(null);
  const [callStatus, setCallStatus] = useState('connecting');
  const [timerSeconds, setTimerSeconds] = useState(1800);

  useEffect(() => {
    if (!property) return;
    const randomProxy = `+1 (888) 555-${Math.floor(1000 + Math.random() * 9000)}`;
    setSession({
      proxyNumber: randomProxy,
      buyerNumber: '+91 99*** **123',
      sellerName: property.sellerName,
      sellerRole: property.sellerRole,
    });

    const timer = setTimeout(() => {
      setCallStatus('active');
    }, 1500);

    const countdown = setInterval(() => {
      setTimerSeconds((prev) => (prev > 0 ? prev - 1 : 0));
    }, 1000);

    return () => {
      clearTimeout(timer);
      clearInterval(countdown);
    };
  }, [property]);

  if (!property || !session) return null;

  const formatTime = (secs) => {
    const m = Math.floor(secs / 60);
    const s = secs % 60;
    return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/85 backdrop-blur-md animate-fadeIn">
      <div className="glass-card max-w-md w-full rounded-2xl p-6 space-y-5 border border-emerald-500/30 text-center relative">
        <button
          onClick={onClose}
          className="absolute top-4 right-4 p-1.5 rounded-lg bg-slate-800 text-slate-400 hover:text-white hover:bg-slate-700"
        >
          <X className="w-5 h-5" />
        </button>

        <div className="mx-auto w-16 h-16 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center border border-emerald-500/40 animate-pulse">
          <PhoneCall className="w-8 h-8" />
        </div>

        <div>
          <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-500/20 text-emerald-300 text-xs font-bold border border-emerald-500/30 mb-2">
            <Lock className="w-3 h-3" /> NEST Uber-Style Telephony Route
          </div>
          <h2 className="text-xl font-bold text-white">Proxy Call Route Connected</h2>
          <p className="text-xs text-slate-400 mt-1">Connecting buyer to {session.sellerName} via NEST proxy line</p>
        </div>

        {/* Proxy Number Box */}
        <div className="bg-slate-900/90 p-4 rounded-xl border border-slate-800 space-y-2">
          <div className="text-xs text-slate-400 font-medium">NEST Encrypted Virtual Proxy Line</div>
          <div className="text-2xl font-black text-emerald-400 tracking-wider font-mono">{session.proxyNumber}</div>
          <div className="text-[11px] text-slate-400 flex items-center justify-center gap-1">
            <ShieldCheck className="w-3.5 h-3.5 text-emerald-400" /> Real Phone Numbers Protected on Both Ends
          </div>
        </div>

        {/* Call Timer & Status */}
        <div className="flex items-center justify-around bg-slate-950/60 p-3 rounded-xl border border-slate-800 text-xs">
          <div>
            <div className="text-slate-400 text-[10px]">Session Status</div>
            <div className="font-bold text-emerald-400 flex items-center gap-1">
              <span className="w-2 h-2 rounded-full bg-emerald-400 animate-ping" />
              <span className="capitalize">{callStatus}</span>
            </div>
          </div>
          <div className="h-6 w-px bg-slate-800" />
          <div>
            <div className="text-slate-400 text-[10px]">Session Expiry</div>
            <div className="font-bold text-slate-200 font-mono flex items-center gap-1">
              <Clock className="w-3 h-3 text-indigo-400" /> {formatTime(timerSeconds)}
            </div>
          </div>
        </div>

        {/* Action Controls */}
        <div className="flex items-center justify-center gap-3 pt-2">
          <button
            onClick={onClose}
            className="w-full py-3 rounded-xl bg-red-600 hover:bg-red-500 text-white font-bold text-sm transition-all shadow-lg shadow-red-600/30 flex items-center justify-center gap-2"
          >
            <PhoneCall className="w-4 h-4 rotate-[135deg]" />
            <span>End NEST Masked Call</span>
          </button>
        </div>
      </div>
    </div>
  );
}

import React from 'react';
import { Eye, Heart, PhoneCall, Bookmark, TrendingUp, Sparkles, Flame, PlusCircle } from 'lucide-react';

export default function BuilderAnalytics({ properties, onStartOnboarding }) {
  const builderProps = properties.filter((p) => p.sellerRole === 'builder');

  const totalViews = builderProps.reduce((sum, p) => sum + p.viewCount, 0);
  const totalLeads = builderProps.reduce((sum, p) => sum + p.leadCount, 0);
  const totalBookmarks = builderProps.reduce((sum, p) => sum + p.bookmarkCount, 0);

  return (
    <div className="space-y-6 animate-fadeIn">
      {/* Top Banner */}
      <div className="glass-card p-6 rounded-2xl border border-amber-500/30 flex flex-col md:flex-row items-center justify-between gap-4">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2.5 py-0.5 rounded-full bg-amber-500/20 text-amber-300 text-xs font-bold border border-amber-500/30">
              Builder Developer Portal
            </span>
            <span className="text-xs text-slate-400">Apex Urban Developers Pvt Ltd</span>
          </div>
          <h2 className="text-2xl font-bold text-white tracking-tight mt-1">Project Portfolio & Engagement Analytics</h2>
          <p className="text-xs text-slate-300">Aggregated, anonymized buyer view counts and masked call inquiry leads</p>
        </div>

        <button
          onClick={onStartOnboarding}
          className="px-4 py-2.5 rounded-xl bg-gradient-to-r from-amber-600 to-orange-600 hover:from-amber-500 hover:to-orange-500 text-white font-bold text-xs shadow-lg flex items-center gap-2 transition-all whitespace-nowrap"
        >
          <PlusCircle className="w-4 h-4" />
          <span>+ Add New Project Scheme</span>
        </button>
      </div>

      {/* Aggregate Metric Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <div className="glass-card p-4 rounded-xl border border-slate-800 space-y-1">
          <div className="flex items-center justify-between text-slate-400 text-xs">
            <span>Total Buyer Views</span>
            <Eye className="w-4 h-4 text-indigo-400" />
          </div>
          <div className="text-2xl font-black text-white">{totalViews.toLocaleString()}</div>
          <div className="text-[10px] text-emerald-400 font-semibold">+18.4% this week</div>
        </div>

        <div className="glass-card p-4 rounded-xl border border-slate-800 space-y-1">
          <div className="flex items-center justify-between text-slate-400 text-xs">
            <span>Masked Call Leads</span>
            <PhoneCall className="w-4 h-4 text-emerald-400" />
          </div>
          <div className="text-2xl font-black text-emerald-400">{totalLeads}</div>
          <div className="text-[10px] text-slate-400">Telephony proxy connected</div>
        </div>

        <div className="glass-card p-4 rounded-xl border border-slate-800 space-y-1">
          <div className="flex items-center justify-between text-slate-400 text-xs">
            <span>Buyer Bookmarks</span>
            <Bookmark className="w-4 h-4 text-amber-400" />
          </div>
          <div className="text-2xl font-black text-amber-300">{totalBookmarks}</div>
          <div className="text-[10px] text-amber-400 font-semibold">High Purchase Intent</div>
        </div>

        <div className="glass-card p-4 rounded-xl border border-slate-800 space-y-1">
          <div className="flex items-center justify-between text-slate-400 text-xs">
            <span>Flash Ad Campaigns</span>
            <Flame className="w-4 h-4 text-red-400" />
          </div>
          <div className="text-2xl font-black text-white">1 Active</div>
          <div className="text-[10px] text-indigo-300">5% Discount Tag Enabled</div>
        </div>
      </div>

      {/* Per Project Performance Table */}
      <div className="glass-card p-5 rounded-2xl border border-slate-800 space-y-4">
        <h3 className="font-bold text-white text-base">Listed Projects & Unit Config Matrix</h3>
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs text-slate-300">
            <thead className="bg-slate-900 text-slate-400 uppercase tracking-wider font-semibold border-b border-slate-800">
              <tr>
                <th className="p-3">Project Title</th>
                <th className="p-3">Configurations</th>
                <th className="p-3">Price Range</th>
                <th className="p-3">Views</th>
                <th className="p-3">Leads</th>
                <th className="p-3">Status</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-800">
              {builderProps.map((p) => (
                <tr key={p.id} className="hover:bg-slate-900/50">
                  <td className="p-3 font-bold text-white">{p.title}</td>
                  <td className="p-3">
                    {p.builderUnitConfigs
                      ? p.builderUnitConfigs.map((u) => u.bhk).join(', ')
                      : p.bhk}
                  </td>
                  <td className="p-3 font-mono font-semibold text-emerald-400">{p.priceFormatted}</td>
                  <td className="p-3 font-bold">{p.viewCount}</td>
                  <td className="p-3 font-bold text-emerald-300">{p.leadCount}</td>
                  <td className="p-3">
                    <span className="px-2 py-0.5 rounded-full bg-emerald-500/20 text-emerald-300 text-[10px] font-bold border border-emerald-500/30">
                      RERA Active
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
